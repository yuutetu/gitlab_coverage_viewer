require 'test_helper'

module GitlabCoverageViewer
  class CoverageControllerTest < ActionController::TestCase
    # test "the truth" do
    #   assert true
    # end

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
  end
end
