class Auroraml < Formula
  desc "Meta-package for auroraml dependencies"
  homepage "https://github.com/aurorasolar/machine-learning"
  head "https://github.com/mjstevens777/homebrew-auroraml.git"

  bottle :unneeded

  depends_on "mjstevens777/auroraml/pcl"
  depends_on "python3"
  depends_on "cmake"
  depends_on "wget"
  depends_on "kops"
  depends_on "opencv"
  depends_on "gdal" => ["with-postgresql", "with-python3"]
  depends_on "cgal"
  depends_on "jsoncpp"
  depends_on "glpk"

  def install
  	return
  end

  test do
  	return
  end
end
