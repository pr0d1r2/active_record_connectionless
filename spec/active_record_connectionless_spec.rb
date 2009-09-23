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
    it 'should provide emulate_attribute method that create emulated activerecord attributes' do
      ActiveRecordConnectionless.should_receive(:attr_accessor).with(:name1)
      ActiveRecordConnectionless.should_receive(:define_method).with("name1_before_type_cast")
      ActiveRecordConnectionless.should_receive(:attr_accessor).with(:name2)
      ActiveRecordConnectionless.should_receive(:define_method).with("name2_before_type_cast")
      ActiveRecordConnectionless.emulate_attribute(:name1, :name2)
    end

    it 'should create an method which points to original attribute' do
      ActiveRecordConnectionless.emulate_attribute(:name)
      active_record_connectionless = ActiveRecordConnectionless.new(:name => 'name')
      active_record_connectionless.name_before_type_cast.should == 'name'
    end

    it 'should create methods which points to original attributes for multiple' do
      ActiveRecordConnectionless.emulate_attribute(:name1, :name2)
      active_record_connectionless = ActiveRecordConnectionless.new(:name1 => 'name1', :name2 => 'name2')
      active_record_connectionless.name1_before_type_cast.should == 'name1'
      active_record_connectionless.name2_before_type_cast.should == 'name2'
    end
  end

end
