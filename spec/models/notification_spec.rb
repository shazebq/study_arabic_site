require 'spec_helper'

describe Notification do
  create_categories
  initialize_records

  it { should respond_to(:recipient) }
  it { should respond_to(:recipient_object) }

  it { should respond_to(:responsible_party) }
  it { should respond_to(:responsible_party_object) }

  
end
