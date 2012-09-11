module Public::PagesHelper
  def progress_size(size)
    size.to_i <= 10 ? 10 : size
  end
end
