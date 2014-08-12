require "minitest/autorun"
require File.expand_path("../../lib/nice/diff.rb", __FILE__)


class TestDiff < MiniTest::Test
  include Nice

  @@expected_json_file = File.open File.expand_path("../fixtures/file1_expected.json", __FILE__)
  @@actual_json_file = File.open File.expand_path("../fixtures/file1_actual.json", __FILE__)
  @@expected_xml_file = File.open File.expand_path("../fixtures/file2_expected.xml", __FILE__)
  @@actual_xml_file = File.open File.expand_path("../fixtures/file2_actual.xml", __FILE__)
  
  def test_diff_parse_to_array    
    expected = [[{"k1"=>"hello", "k2"=>"gem"}], [{"k1"=>"hello", "k2"=>"ruby_plugin"}]]    
    actual = Diff.new("JSON", @@expected_json_file, @@actual_json_file).parse_to_array
    assert_equal(expected, actual)
        
    expected = [[{"k1"=>"hola", "k2"=>"gem"}], [{"k1"=>"hola", "k2"=>"ruby_plugin"}]]
    actual = Diff.new("XML", @@expected_xml_file, @@actual_xml_file).parse_to_array
    assert_equal(expected, actual)
  end  

  def test_diff_print_hash_diff
    expected = {"1"=>"ruby_plugin"}
    actual = Diff.print_hash_diff(expected_hash: {"k1"=>"hello", "k2"=>"gem"}, actual_hash: {"k1"=>"hello", "k2"=>"ruby_plugin"}, headers: ["k1", "k2"])
    assert_equal(expected, actual)
  end

  def test_diff_print
    expected = {"1"=>"ruby_plugin"}
    Diff.new("JSON", @@expected_json_file, @@actual_json_file).print
    actual = Diff.hash_print
    assert_equal(expected, actual)
    
    expected = {"1"=>"ruby_plugin"}
    Diff.new("XML", @@expected_xml_file, @@actual_xml_file).print
    actual = Diff.hash_print
    assert_equal(expected, actual)    
  end  
end
