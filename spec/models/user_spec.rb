require 'spec_helper'

describe User do

  describe :to_s do
    it 'returns the users first and last name' do
      user = User.new(first_name: 'John', last_name: 'Doe')
      expect(user.to_s).to eq('John Doe')
    end
  end

end
