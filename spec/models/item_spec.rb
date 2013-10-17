require 'spec_helper'

describe Item do
  it { should belong_to :project }
  it { should belong_to :creator }
  it { should belong_to :assignee }
end
