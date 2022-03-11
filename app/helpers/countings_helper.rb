# Countings helper
module CountingsHelper
  def filter_by(name, status, **options)
    link_to name, request.params.merge(status: status), **options
  end
end
