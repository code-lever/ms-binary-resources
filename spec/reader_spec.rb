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

  describe '#key?' do

    %w(Title Label1 Label2 Label3 Label4 Label5 Label6 Label7 Label8
       Label9 Label10 Label11 Label12 Label13 Label14 Label15).each do |key|
      it "is true for #{key}" do
        expect(subject.key?(key)).to be_truthy
      end
    end

    it 'is false for keys not present' do
      expect(subject.key?('hello')).to be_falsey
    end

  end

  describe '#[]' do

    {
      'Title' => '"Contact Information"',
      'Label1' => '"First Name:"',
      'Label2' => '"Middle Name:"',
      'Label3' => '"Last Name:"',
      'Label4' => '"SSN:"',
      'Label5' => '"Street Address:"',
      'Label6' => '"City:"',
      'Label7' => '"State:"',
      'Label8' => '"Zip Code:"',
      'Label9' => '"Home Phone:"',
      'Label10' => '"Business Phone:"',
      'Label11' => '"Mobile Phone:"',
      'Label12' => '"Other Phone:"',
      'Label13' => '"Fax:"',
      'Label14' => '"Email Address:"',
      'Label15' => '"Alternate Email Address:"',
    }.each do |key, value|
      it "is #{value} for #{key}" do
        expect(subject[key]).to eql(value)
      end
    end

  end

end
