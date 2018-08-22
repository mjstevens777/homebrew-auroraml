class Pdal < Formula
  desc "Point data abstraction library"
  homepage "https://www.pdal.io/"
  # Change this back to PDAL/PDAL after 1.7.3 is released
  url "https://github.com/mjstevens777/PDAL/archive/1.7.2.rc1.tar.gz"
  sha256 "00d05e037a9c15a12c2bd0b51e3faec952b8a93ef20945b5ce617b2273b20ec2"
  head "https://github.com/PDAL/PDAL.git"

  bottle do
    root_url "https://s3.amazonaws.com/aurorasolar-envision/homebrew"
    # Do not use the bottle from the original package
    rebuild 1
    sha256 "3fa1a7fdfb022d02ff5ec58901eca161314413179e72c65022aa2d7e1b095342" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "gdal"
  depends_on "hdf5"
  depends_on "laszip"
  depends_on "numpy"
  depends_on "mjstevens777/auroraml/pcl"
  depends_on "postgresql"
  depends_on "python"

  def install
    system "cmake", ".", *std_cmake_args,
                         "-DWITH_LASZIP=TRUE",
                         "-DBUILD_PLUGIN_GREYHOUND=ON",
                         "-DBUILD_PLUGIN_ICEBRIDGE=ON",
                         "-DBUILD_PLUGIN_PCL=ON",
                         "-DBUILD_PLUGIN_PGPOINTCLOUD=ON",
                         "-DBUILD_PLUGIN_PYTHON=ON",
                         "-DBUILD_PLUGIN_SQLITE=ON",
                         # https://github.com/Kitware/CMake/blob/8901b9fe89acd4a2a739f22029e9bb473a04569f/Modules/FindPythonLibs.cmake#L29
                         "-DPython_ADDITIONAL_VERSIONS=3.7"

    system "make", "install"
    doc.install "examples", "test"
  end

  test do
    system bin/"pdal", "info", doc/"test/data/las/interesting.las"
  end
end
