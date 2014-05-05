require_dependency "gitlab_coverage_viewer/application_controller"

module GitlabCoverageViewer
  class CoverageController < ::Projects::ApplicationController
    include ExtractsPath

    # Authorize
    before_filter :authorize_read_project!
    before_filter :authorize_code_access!
    before_filter :check_for_coverage_enable!
    before_filter :require_non_empty_project
    before_filter :blob

    def show
      # not implement
    end

    private
    def blob
      @blob ||= @repository.blob_at(@commit.id, @path)
      return not_found! unless @blob
      @blob
    end

    def check_for_coverage_enable!
      return not_found! unless @project.coverage_enabled
     end
  end
end
