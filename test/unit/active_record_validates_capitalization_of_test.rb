require File.dirname(__FILE__) + "/../test_helper"

class TestRecord < ActiveRecord::Base
end

class ActiveRecordValidatesCapitalizationOfTest < Test::Unit::TestCase
  
  def setup
    @connection = ActiveRecord::Base.connection
    @connection.create_table :test_records do |t|
      t.column :booya, :string
    end
    
    @test_record_class = TestRecord #Class.new ActiveRecord::Base
  end
  
  def teardown
    @connection.drop_table :test_records
  end
  
  def test_case_equal_to_upper
    @test_record_class.class_eval do
      validates_capitalization_of :booya, :casing => 'upper'
    end
    test_record = @test_record_class.new
    test_record.booya = "lower case string"
    
    assert !test_record.valid?
  end
  
end