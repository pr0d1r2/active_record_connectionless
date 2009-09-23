require 'rubygems'
require 'active_record'

ActiveRecord::Base.class_eval do

  def self.columns
    @columns ||= [];
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  # Override the save method to prevent exceptions.
  def save(validate = true)
    validate ? valid? : true
  end

  def self.emulate_attribute(*names)
    names.each do |name|
      attr_accessor name
      define_method("#{name}_before_type_cast") do
        self.send(name)
      end
    end
  end

end
