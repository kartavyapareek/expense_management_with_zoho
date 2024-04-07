# frozen_string_literal: true

json.extract! expense_report, :id, :created_at, :updated_at
json.url expense_report_url(expense_report, format: :json)
