# Tokenized Veterinary Telemedicine Networks

A comprehensive blockchain-based veterinary telemedicine platform built on the Stacks blockchain using Clarity smart contracts.

## Overview

This project implements a decentralized veterinary telemedicine network that enables remote veterinary consultations, diagnostic support, prescription management, and follow-up care coordination. The system ensures transparency, security, and traceability of all veterinary interactions through blockchain technology.

## Features

### 🏥 Veterinarian Verification
- Secure veterinarian registration and verification system
- License validation and credential management
- Admin-controlled verification process
- Status tracking and management

### 💬 Consultation Management
- Remote consultation booking and scheduling
- Real-time consultation status tracking
- Fee management and payment processing
- Consultation history and records

### 🔬 Diagnostic Support
- Remote diagnostic request submission
- Specialist veterinarian assignment
- Image and data sharing capabilities
- Diagnostic result management with confidence levels

### 💊 Prescription Management
- Digital prescription issuance
- Pharmacy dispensing tracking
- Prescription validity verification
- Cancellation and modification controls

### 📅 Follow-up Coordination
- Automated follow-up appointment scheduling
- Reminder system for pet owners
- Progress tracking and notes
- Flexible cancellation policies

## Smart Contracts

### 1. Veterinarian Verification Contract (\`veterinarian-verification.clar\`)
Manages the registration and verification of veterinary professionals.

**Key Functions:**
- \`register-veterinarian\`: Register new veterinarians
- \`verify-veterinarian\`: Admin verification of credentials
- \`get-veterinarian\`: Retrieve veterinarian information
- \`is-verified\`: Check verification status

### 2. Consultation Management Contract (\`consultation-management.clar\`)
Handles remote veterinary consultations from request to completion.

**Key Functions:**
- \`request-consultation\`: Create consultation requests
- \`accept-consultation\`: Veterinarian acceptance
- \`complete-consultation\`: Mark consultations as completed
- \`get-consultation\`: Retrieve consultation details

### 3. Diagnostic Support Contract (\`diagnostic-support.clar\`)
Provides remote diagnostic support and specialist consultations.

**Key Functions:**
- \`submit-diagnostic-request\`: Submit diagnostic requests
- \`accept-diagnostic-request\`: Specialist acceptance
- \`submit-diagnostic-results\`: Provide diagnostic results
- \`get-diagnostic-results\`: Retrieve diagnostic information

### 4. Prescription Management Contract (\`prescription-management.clar\`)
Manages digital prescriptions and pharmacy dispensing.

**Key Functions:**
- \`issue-prescription\`: Issue new prescriptions
- \`dispense-prescription\`: Pharmacy dispensing
- \`cancel-prescription\`: Cancel prescriptions
- \`is-prescription-valid\`: Verify prescription validity

### 5. Follow-up Coordination Contract (\`follow-up-coordination.clar\`)
Coordinates follow-up care and appointment scheduling.

**Key Functions:**
- \`schedule-followup\`: Schedule follow-up appointments
- \`complete-followup\`: Complete follow-up visits
- \`create-reminder\`: Set up reminders
- \`cancel-followup\`: Cancel appointments

## Installation

### Prerequisites
- Node.js (v16 or higher)
- Clarinet CLI
- Stacks Wallet

### Setup

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/your-org/vet-telemedicine-network.git
   cd vet-telemedicine-network
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Initialize Clarinet project:
   \`\`\`bash
   clarinet new vet-telemedicine
   cd vet-telemedicine
   \`\`\`

4. Copy contract files to the \`contracts\` directory

5. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Usage

### For Veterinarians

1. **Registration**: Register with credentials and specialization
2. **Verification**: Wait for admin verification of credentials
3. **Consultations**: Accept and manage consultation requests
4. **Diagnostics**: Request specialist support when needed
5. **Prescriptions**: Issue digital prescriptions
6. **Follow-ups**: Schedule and manage follow-up care

### For Pet Owners

1. **Consultations**: Request consultations with verified veterinarians
2. **Appointments**: Schedule and manage appointments
3. **Prescriptions**: Receive and track digital prescriptions
4. **Follow-ups**: Attend scheduled follow-up appointments

### For Pharmacies

1. **Prescriptions**: Verify and dispense digital prescriptions
2. **Tracking**: Update dispensing status in the system

### For Specialists

1. **Diagnostics**: Accept and provide diagnostic support
2. **Results**: Submit detailed diagnostic results with confidence levels

## Testing

The project includes comprehensive tests for all smart contracts using Vitest:

\`\`\`bash
# Run all tests
npm test

# Run specific contract tests
npm test veterinarian-verification
npm test consultation-management
npm test diagnostic-support
npm test prescription-management
npm test follow-up-coordination
\`\`\`

## Security Considerations

- **Access Control**: Role-based permissions for different user types
- **Data Validation**: Input validation and sanitization
- **Status Management**: Proper state transitions and validations
- **Authorization**: Function-level authorization checks
- **Immutability**: Blockchain-based audit trail

## Error Codes

Each contract uses specific error codes for different failure scenarios:

- **100-199**: Veterinarian Verification errors
- **200-299**: Consultation Management errors
- **300-399**: Diagnostic Support errors
- **400-499**: Prescription Management errors
- **500-599**: Follow-up Coordination errors

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation wiki

## Roadmap

- [ ] Mobile application integration
- [ ] AI-powered diagnostic assistance
- [ ] Multi-language support
- [ ] Integration with existing veterinary systems
- [ ] Advanced analytics and reporting
- [ ] Telemedicine video integration
- [ ] IoT device integration for remote monitoring
  \`\`\`

Finally, let's create the PR details file:
