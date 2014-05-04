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
  end
end
