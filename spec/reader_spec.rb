require 'spec_helper'

describe Ms::BinaryResources::Reader do

  let(:file) { data_file('Example.resources') }

  subject { described_class.new(file) }

  its(:manager_magic) { should eql(0xBEEFCACE) }

  its(:manager_version) { should eql(1) }

  its(:manager_length) { should eql(145) }

  its(:resource_version) { should eql(2) }

  its(:resource_count) { should eql(16) }

  its(:type_count) { should eql(0) }

end
