require 'spec_helper'

describe PagesController do

  describe :index do
    it "returns 200 success" do
      get :index
      expect(response.status).to eq(200)
    end
  end

end
