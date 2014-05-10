require 'test_helper'

module GitlabCoverageViewer
  module CoverageFormatter
    class PhpUnitCloverFormatterTest < ActiveSupport::TestCase
      def test_parse
        response_mock = mock(headers: {"Content-Type" => "application/octet-stream" })
        project_mock = mock(coverage_base_path: "/path/to/workspace/")
        path = "path/to/sample.php"
        file = File.open "#{Rails.root}/../lib/gitlab_coverage_viewer/php_unit_clover_coverage.xml"
        xml_file = file.read
        response_mock.stubs(:body).returns(xml_file)
        result = GitlabCoverageViewer::CoverageFormatter::PhpUnitCloverFormatter.parse response_mock, project_mock, path
        expected_result = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 3, 3, 3, nil, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, nil, 3, 3, 3, 3, 3]
        assert_equal expected_result, result
      end

      def test_desc
        assert_equal GitlabCoverageViewer::CoverageFormatter::PhpUnitCloverFormatter.desc, "PHP/PHPUnit/CloverXML"
      end
    end
  end
end
