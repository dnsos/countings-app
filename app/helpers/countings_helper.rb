# Countings helper
module CountingsHelper
  def filter_by(name, status, **options)
    render(
      ButtonComponent.new(
        scheme: :link,
        tag: :a,
        href: request.params.merge(status: status),
        class: 'underline inline px-0',
        **options,
      ),
    ) { name }
  end
end
