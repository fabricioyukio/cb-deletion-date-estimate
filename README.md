# cb-deletion-date-estimate

A gem for estimate deletion dates of snapshots given its Retention Plan Name and its Creation date. I should say that if the given snapshot is due to deletion, or if it should stay in the storage.

## Usage
Just add the gem to your project and the following method:
```
CbDeletionDateEstimate.is_due?(retention_plan,created_at)
```
* **retention_plan** (String) the client's retention_plan (one of Standard, Gold, or Platinum)
* **created_at** (Date) is the date of the creation of the snapshot.

## The Rules

The plans and rules are the following:

### Standard

* We will retain each snapshot daily for 42 days.

### Gold

* We will retain each snapshot daily for 42 days.
* We will retain the last snapshot of the month for 12 months.

### Platinum (42 days, 12 months and 7 years)

* We will retain each snapshot daily for 42 days.
* We will retain the last snapshot of the month for 12 months.
* We will retain the last snapshot of the year for 7 years.

## Other Premises

### Daily Backup
Every day an snapshot is created and stored.
Also every day the stored snapshots are tested to check if such snapshot is due to deletion, according to Owner's Retention Plan.