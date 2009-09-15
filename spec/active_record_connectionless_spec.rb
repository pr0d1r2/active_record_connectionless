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

end
