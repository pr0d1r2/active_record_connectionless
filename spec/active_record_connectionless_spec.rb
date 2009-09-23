require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class ActiveRecordConnectionless < ActiveRecord::Base
end


describe "ActiveRecordConnectionless" do

  it 'should allow to make new object without exception' do
    lambda {
      ActiveRecordConnectionless.new
    }.should_not raise_error(ActiveRecord::ConnectionNotEstablished)
  end

  it 'should allow to save new object without exception' do
    lambda {
      ActiveRecordConnectionless.new.save
    }.should_not raise_error(ActiveRecord::ConnectionNotEstablished)
  end

  describe 'emulate_attribute' do
    it 'should provide emulate_attribute method that create emulated activerecord attribute' do
      ActiveRecordConnectionless.should_receive(:attr_accessor).with(:name)
      ActiveRecordConnectionless.should_receive(:define_method).with("name_before_type_cast")
      ActiveRecordConnectionless.emulate_attribute(:name)
    end

    it 'should create an method which points to original attribute' do
      ActiveRecordConnectionless.emulate_attribute(:name)
      active_record_connectionless = ActiveRecordConnectionless.new(:name => 'name')
      active_record_connectionless.name_before_type_cast.should == 'name'
    end
  end

end
