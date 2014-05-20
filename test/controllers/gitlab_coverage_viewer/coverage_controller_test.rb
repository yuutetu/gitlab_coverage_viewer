require 'test_helper'

module GitlabCoverageViewer
  class CoverageControllerTest < ActionController::TestCase

    setup do
      @routes = GitlabCoverageViewer::Engine.routes
    end

    test "super class is Projects::ApplicationController" do
      assert_equal GitlabCoverageViewer::CoverageController.superclass, Projects::ApplicationController
    end

    test "included ExtractsPath" do
      assert GitlabCoverageViewer::CoverageController.ancestors.include?(ExtractsPath)
    end

    test "if coverage_enabled of this project is false, return not_found response" do
      @controller.instance_variable_set(:@project, mock(coverage_enabled: false))
      @controller.expects(:not_found!).at_least_once
      @controller.send(:check_for_coverage_enable!)
    end

    test "if blob is nil, return not_found response" do
      repository_mock = mock()
      @controller.instance_variable_set(:@repository, repository_mock)
      @controller.instance_variable_set(:@commit, mock(id: 1))
      @controller.instance_variable_set(:@path, "path")
      repository_mock.stubs(:blob_at).with(1, "path").returns(nil)
      @controller.expects(:not_found!).at_least_once
      @controller.send(:blob)
    end

    def test_show
      @controller.stubs(:authorize_read_project!).returns(true)
      @controller.stubs(:authorize_code_access!).returns(true)
      @controller.stubs(:check_for_coverage_enable!).returns(true)
      @controller.stubs(:require_non_empty_project).returns(true)
      @controller.stubs(:blob).returns(true)
      @controller.stubs(:render).returns(true)
      # project mock
      project_mock = mock()
      project_mock.stubs(:coverage_url_with_commit_id).with("commit_id").returns("http://aa.org/path/to/coverage.json")
      project_mock.stubs(:coverage_parse_type).returns("simple_cov_json_formatter")
      # commit mock
      commit_mock = mock(id: "commit_id")
      # response mock
      response_mock = mock()
      coverage_mock = mock()
      # set mocks
      @controller.instance_variable_set(:@project, project_mock)
      @controller.instance_variable_set(:@commit,  commit_mock)
      @controller.instance_variable_set(:@path,  "app/path/to/program.rb")

      # expect method call
      Faraday.stubs(:get).with("http://aa.org/path/to/coverage.json").returns(response_mock)
      GitlabCoverageViewer::CoverageFormatter::SimpleCovJsonFormatter.stubs(:parse).with(response_mock, project_mock, "app/path/to/program.rb").returns(coverage_mock)
      get :show, id: "app/path/to/program.rb"
      assert_equal coverage_mock, assigns(:coverage)
    end
  end
end
