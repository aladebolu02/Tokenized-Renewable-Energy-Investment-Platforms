;; Investment Management Contract
;; Manages renewable energy project investments

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_PROJECT_NOT_FOUND (err u201))
(define-constant ERR_INSUFFICIENT_FUNDS (err u202))
(define-constant ERR_INVESTMENT_CLOSED (err u203))
(define-constant ERR_MINIMUM_NOT_MET (err u204))

;; Project data structure
(define-map projects
  { project-id: uint }
  {
    developer-id: uint,
    name: (string-ascii 100),
    target-amount: uint,
    raised-amount: uint,
    minimum-investment: uint,
    deadline: uint,
    status: (string-ascii 20),
    energy-type: (string-ascii 30)
  }
)

;; Investment tracking
(define-map investments
  { project-id: uint, investor: principal }
  { amount: uint, timestamp: uint }
)

;; Project investors list
(define-map project-investors
  { project-id: uint }
  { investors: (list 100 principal) }
)

(define-data-var next-project-id uint u1)

;; Create a new investment project
(define-public (create-project
  (developer-id uint)
  (name (string-ascii 100))
  (target-amount uint)
  (minimum-investment uint)
  (deadline uint)
  (energy-type (string-ascii 30))
)
  (let ((project-id (var-get next-project-id)))
    (map-set projects
      { project-id: project-id }
      {
        developer-id: developer-id,
        name: name,
        target-amount: target-amount,
        raised-amount: u0,
        minimum-investment: minimum-investment,
        deadline: deadline,
        status: "open",
        energy-type: energy-type
      }
    )
    (var-set next-project-id (+ project-id u1))
    (ok project-id)
  )
)

;; Invest in a project
(define-public (invest (project-id uint) (amount uint))
  (match (map-get? projects { project-id: project-id })
    project-data
    (if (and
          (is-eq (get status project-data) "open")
          (< block-height (get deadline project-data))
          (>= amount (get minimum-investment project-data))
        )
      (begin
        ;; Update project raised amount
        (map-set projects
          { project-id: project-id }
          (merge project-data {
            raised-amount: (+ (get raised-amount project-data) amount)
          })
        )
        ;; Record investment
        (map-set investments
          { project-id: project-id, investor: tx-sender }
          { amount: amount, timestamp: block-height }
        )
        ;; Add to investors list (simplified)
        (ok true)
      )
      ERR_INVESTMENT_CLOSED
    )
    ERR_PROJECT_NOT_FOUND
  )
)

;; Get project details
(define-read-only (get-project (project-id uint))
  (map-get? projects { project-id: project-id })
)

;; Get investment details
(define-read-only (get-investment (project-id uint) (investor principal))
  (map-get? investments { project-id: project-id, investor: investor })
)

;; Close project funding
(define-public (close-project (project-id uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? projects { project-id: project-id })
      project-data
      (begin
        (map-set projects
          { project-id: project-id }
          (merge project-data { status: "closed" })
        )
        (ok true)
      )
      ERR_PROJECT_NOT_FOUND
    )
    ERR_UNAUTHORIZED
  )
)
