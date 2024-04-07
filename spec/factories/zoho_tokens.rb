# frozen_string_literal: true

FactoryBot.define do
  factory :zoho_token do
    access { 'new_access_token' }
    refresh { 'new_refresh_token' }
    expires_at { '2021-08-26 15:00:00' }
  end
end
