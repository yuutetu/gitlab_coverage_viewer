class Project < ActiveRecord::Base
  def coverage_url_with_commit_id commit_id
    begin
      meta_url = self.coverage_url
      meta_url["{commit_id}"] = commit_id
    rescue IndexError
    end
    meta_url
  end
end