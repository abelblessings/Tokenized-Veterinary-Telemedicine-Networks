;; Follow-up Coordination Contract
;; Coordinates veterinary follow-up care

(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_FOLLOWUP_NOT_FOUND (err u501))
(define-constant ERR_INVALID_STATUS (err u502))

;; Follow-up appointment structure
(define-map follow-up-appointments
  { followup-id: uint }
  {
    original-consultation-id: uint,
    veterinarian: principal,
    pet-owner: principal,
    followup-type: (string-ascii 50),
    scheduled-date: uint,
    notes: (string-ascii 500),
    status: (string-ascii 20),
    created-date: uint,
    completed-date: (optional uint)
  }
)

;; Follow-up reminders
(define-map follow-up-reminders
  { reminder-id: uint }
  {
    followup-id: uint,
    reminder-date: uint,
    message: (string-ascii 200),
    sent: bool
  }
)

(define-data-var next-followup-id uint u1)
(define-data-var next-reminder-id uint u1)

;; Schedule follow-up appointment
(define-public (schedule-followup (consultation-id uint) (pet-owner principal) (followup-type (string-ascii 50)) (scheduled-date uint) (notes (string-ascii 500)))
  (let ((followup-id (var-get next-followup-id)))
    (map-set follow-up-appointments
      { followup-id: followup-id }
      {
        original-consultation-id: consultation-id,
        veterinarian: tx-sender,
        pet-owner: pet-owner,
        followup-type: followup-type,
        scheduled-date: scheduled-date,
        notes: notes,
        status: "scheduled",
        created-date: block-height,
        completed-date: none
      }
    )
    (var-set next-followup-id (+ followup-id u1))
    (ok followup-id)
  )
)

;; Complete follow-up appointment
(define-public (complete-followup (followup-id uint) (completion-notes (string-ascii 500)))
  (match (map-get? follow-up-appointments { followup-id: followup-id })
    followup-data
    (begin
      (asserts! (is-eq tx-sender (get veterinarian followup-data)) ERR_UNAUTHORIZED)
      (asserts! (is-eq (get status followup-data) "scheduled") ERR_INVALID_STATUS)
      (map-set follow-up-appointments
        { followup-id: followup-id }
        (merge followup-data {
          status: "completed",
          completed-date: (some block-height),
          notes: completion-notes
        })
      )
      (ok true)
    )
    ERR_FOLLOWUP_NOT_FOUND
  )
)

;; Create follow-up reminder
(define-public (create-reminder (followup-id uint) (reminder-date uint) (message (string-ascii 200)))
  (match (map-get? follow-up-appointments { followup-id: followup-id })
    followup-data
    (begin
      (asserts! (is-eq tx-sender (get veterinarian followup-data)) ERR_UNAUTHORIZED)
      (let ((reminder-id (var-get next-reminder-id)))
        (map-set follow-up-reminders
          { reminder-id: reminder-id }
          {
            followup-id: followup-id,
            reminder-date: reminder-date,
            message: message,
            sent: false
          }
        )
        (var-set next-reminder-id (+ reminder-id u1))
        (ok reminder-id)
      )
    )
    ERR_FOLLOWUP_NOT_FOUND
  )
)

;; Get follow-up appointment
(define-read-only (get-followup (followup-id uint))
  (map-get? follow-up-appointments { followup-id: followup-id })
)

;; Get follow-up reminder
(define-read-only (get-reminder (reminder-id uint))
  (map-get? follow-up-reminders { reminder-id: reminder-id })
)

;; Cancel follow-up appointment
(define-public (cancel-followup (followup-id uint))
  (match (map-get? follow-up-appointments { followup-id: followup-id })
    followup-data
    (begin
      (asserts! (or (is-eq tx-sender (get veterinarian followup-data)) (is-eq tx-sender (get pet-owner followup-data))) ERR_UNAUTHORIZED)
      (asserts! (is-eq (get status followup-data) "scheduled") ERR_INVALID_STATUS)
      (map-set follow-up-appointments
        { followup-id: followup-id }
        (merge followup-data { status: "cancelled" })
      )
      (ok true)
    )
    ERR_FOLLOWUP_NOT_FOUND
  )
)
