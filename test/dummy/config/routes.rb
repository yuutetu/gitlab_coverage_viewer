Rails.application.routes.draw do

  mount GitlabCoverageViewer::Engine => "/gitlab_coverage_viewer"
end
