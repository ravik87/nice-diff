require "minitest/autorun"
require File.expand_path("../../lib/nice/diff/parser.rb", __FILE__)
require File.expand_path("../../lib/nice/diff.rb", __FILE__)


class TestParser < MiniTest::Test
  include Nice

  @@expected_json_file = File.open File.expand_path("../fixtures/file1_expected.json", __FILE__)
  @@actual_json_file = File.open File.expand_path("../fixtures/file1_actual.json", __FILE__)
  @@expected_xml_file = File.open File.expand_path("../fixtures/file2_expected.xml", __FILE__)
  @@actual_xml_file = File.open File.expand_path("../fixtures/file2_actual.xml", __FILE__)

 
  def test_abstract_method
    assert_raises RuntimeError, 'Abstract method called: parse_to_array' do
      Parser.new.parse_to_array(self)
    end
  end
 
  def test_parser_parse_to_array
    expected = [[{"k1"=>"hello", "k2"=>"gem"}], [{"k1"=>"hello", "k2"=>"ruby_plugin"}]]
    actual = JSONParser.new.parse_to_array(Diff.new("JSON", @@expected_json_file, @@actual_json_file))
    assert_equal(expected, actual)
 
    expected = [[{"k1"=>"hola", "k2"=>"gem"}], [{"k1"=>"hola", "k2"=>"ruby_plugin"}]]
    actual = XMLParser.new.parse_to_array(Diff.new("XML", @@expected_xml_file, @@actual_xml_file))
    assert_equal(expected, actual)    
  end
end