;; Developer Verification Contract
;; Validates and manages renewable energy project developers

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_DEVELOPER (err u103))

;; Developer data structure
(define-map developers
  { developer-id: uint }
  {
    address: principal,
    name: (string-ascii 50),
    verified: bool,
    verification-date: uint,
    projects-count: uint,
    reputation-score: uint
  }
)

(define-data-var next-developer-id uint u1)

;; Register a new developer
(define-public (register-developer (name (string-ascii 50)))
  (let ((developer-id (var-get next-developer-id)))
    (map-set developers
      { developer-id: developer-id }
      {
        address: tx-sender,
        name: name,
        verified: false,
        verification-date: u0,
        projects-count: u0,
        reputation-score: u50
      }
    )
    (var-set next-developer-id (+ developer-id u1))
    (ok developer-id)
  )
)

;; Verify a developer (only contract owner)
(define-public (verify-developer (developer-id uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? developers { developer-id: developer-id })
      developer-data
      (if (get verified developer-data)
        ERR_ALREADY_VERIFIED
        (begin
          (map-set developers
            { developer-id: developer-id }
            (merge developer-data {
              verified: true,
              verification-date: block-height
            })
          )
          (ok true)
        )
      )
      ERR_NOT_FOUND
    )
    ERR_UNAUTHORIZED
  )
)

;; Get developer information
(define-read-only (get-developer (developer-id uint))
  (map-get? developers { developer-id: developer-id })
)

;; Check if developer is verified
(define-read-only (is-developer-verified (developer-id uint))
  (match (map-get? developers { developer-id: developer-id })
    developer-data (get verified developer-data)
    false
  )
)

;; Update developer reputation
(define-public (update-reputation (developer-id uint) (new-score uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? developers { developer-id: developer-id })
      developer-data
      (begin
        (map-set developers
          { developer-id: developer-id }
          (merge developer-data { reputation-score: new-score })
        )
        (ok true)
      )
      ERR_NOT_FOUND
    )
    ERR_UNAUTHORIZED
  )
)
