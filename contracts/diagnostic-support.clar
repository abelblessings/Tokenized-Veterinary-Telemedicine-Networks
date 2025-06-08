;; Diagnostic Support Contract
;; Provides remote diagnostic support

(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_DIAGNOSTIC_NOT_FOUND (err u301))
(define-constant ERR_INVALID_STATUS (err u302))

;; Diagnostic request structure
(define-map diagnostic-requests
  { request-id: uint }
  {
    consultation-id: uint,
    requesting-vet: principal,
    specialist-vet: (optional principal),
    diagnostic-type: (string-ascii 50),
    symptoms: (string-ascii 500),
    images-hash: (optional (string-ascii 64)),
    status: (string-ascii 20),
    created-date: uint,
    completed-date: (optional uint)
  }
)

;; Diagnostic results
(define-map diagnostic-results
  { request-id: uint }
  {
    diagnosis: (string-ascii 500),
    recommendations: (string-ascii 500),
    confidence-level: uint,
    specialist-vet: principal,
    result-date: uint
  }
)

(define-data-var next-request-id uint u1)

;; Submit diagnostic request
(define-public (submit-diagnostic-request (consultation-id uint) (diagnostic-type (string-ascii 50)) (symptoms (string-ascii 500)) (images-hash (optional (string-ascii 64))))
  (let ((request-id (var-get next-request-id)))
    (map-set diagnostic-requests
      { request-id: request-id }
      {
        consultation-id: consultation-id,
        requesting-vet: tx-sender,
        specialist-vet: none,
        diagnostic-type: diagnostic-type,
        symptoms: symptoms,
        images-hash: images-hash,
        status: "pending",
        created-date: block-height,
        completed-date: none
      }
    )
    (var-set next-request-id (+ request-id u1))
    (ok request-id)
  )
)

;; Accept diagnostic request (specialist)
(define-public (accept-diagnostic-request (request-id uint))
  (match (map-get? diagnostic-requests { request-id: request-id })
    request-data
    (begin
      (asserts! (is-eq (get status request-data) "pending") ERR_INVALID_STATUS)
      (map-set diagnostic-requests
        { request-id: request-id }
        (merge request-data {
          specialist-vet: (some tx-sender),
          status: "in-progress"
        })
      )
      (ok true)
    )
    ERR_DIAGNOSTIC_NOT_FOUND
  )
)

;; Submit diagnostic results
(define-public (submit-diagnostic-results (request-id uint) (diagnosis (string-ascii 500)) (recommendations (string-ascii 500)) (confidence-level uint))
  (match (map-get? diagnostic-requests { request-id: request-id })
    request-data
    (begin
      (asserts! (is-eq (some tx-sender) (get specialist-vet request-data)) ERR_UNAUTHORIZED)
      (asserts! (is-eq (get status request-data) "in-progress") ERR_INVALID_STATUS)

      ;; Update request status
      (map-set diagnostic-requests
        { request-id: request-id }
        (merge request-data {
          status: "completed",
          completed-date: (some block-height)
        })
      )

      ;; Store results
      (map-set diagnostic-results
        { request-id: request-id }
        {
          diagnosis: diagnosis,
          recommendations: recommendations,
          confidence-level: confidence-level,
          specialist-vet: tx-sender,
          result-date: block-height
        }
      )
      (ok true)
    )
    ERR_DIAGNOSTIC_NOT_FOUND
  )
)

;; Get diagnostic request
(define-read-only (get-diagnostic-request (request-id uint))
  (map-get? diagnostic-requests { request-id: request-id })
)

;; Get diagnostic results
(define-read-only (get-diagnostic-results (request-id uint))
  (map-get? diagnostic-results { request-id: request-id })
)
