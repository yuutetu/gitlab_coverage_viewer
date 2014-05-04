require_dependency "gitlab_coverage_viewer/application_controller"

module GitlabCoverageViewer
  class CoverageController < ::Projects::ApplicationController
    include ExtractsPath
  end
end
