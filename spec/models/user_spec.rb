# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  city                   :string
#  date_of_birth          :date
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  gender                 :string
#  grade                  :integer
#  id_no                  :string           default(""), not null
#  last_name              :string           default(""), not null
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("Student")
#  room                   :string
#  start_date             :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  login_id               :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_login_id              (login_id) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
