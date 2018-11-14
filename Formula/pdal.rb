class Pdal < Formula
  desc "Point data abstraction library"
  homepage "https://www.pdal.io/"
  url "https://github.com/PDAL/PDAL/archive/1.8.0.tar.gz"
  sha256 "ef3a32c06865383feac46fd7eb7491f034cad6b0b246b3c917271ae0c8f25b69"
  head "https://github.com/PDAL/PDAL.git"

  bottle do
    root_url "https://s3.amazonaws.com/aurorasolar-envision/homebrew"
    # Do not use the bottle from the original package
    rebuild 1
    sha256 "bd3db1313841359c78bc1b9faa2ce5a1ee6150054d28754a35c458385afae9d9" => :mojave
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
