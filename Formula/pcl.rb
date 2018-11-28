class Pcl < Formula
  desc "Library for 2D/3D image and point cloud processing"
  homepage "http://www.pointclouds.org/"
  revision 3
  head "https://github.com/PointCloudLibrary/pcl.git"

  stable do
    url "https://github.com/PointCloudLibrary/pcl/archive/pcl-1.8.1.tar.gz"
    sha256 "5a102a2fbe2ba77c775bf92c4a5d2e3d8170be53a68c3a76cfc72434ff7b9783"
    # NOTE: Removed VTK patch
  end

  bottle do
    root_url "https://s3.amazonaws.com/aurorasolar-envision/homebrew"
    # Do not use the bottle from the original package
    rebuild 1
    sha256 "c8093d129aa04168926ca2ca42de26bdd49a45430988f6e49feb31bf703c51b0" => :high_sierra
    sha256 "9f1cfaffa5b59d086d58d83e09c02d8926c7006698ab82668a5e8db00f08d4e7" => :mojave
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "cminpack"
  depends_on "eigen"
  depends_on "flann"
  depends_on "glew"
  depends_on "libusb"
  depends_on "qhull"
  # NOTE: Removed VTK dependency

  def install
    # Fix "error: no matching constructor for initialization of
    # 'boost::uuids::random_generator' (aka 'boost::uuids::random_generator_pure')"
    # Upstream issue 18 Apr 2018 "Fails to build against Boost 1.67"
    # See https://github.com/PointCloudLibrary/pcl/issues/2284
    ENV.append "CXXFLAGS", "-DBOOST_UUID_RANDOM_GENERATOR_COMPAT"

    # NOTE: Added WITH_VTK=OFF
    args = std_cmake_args + %w[
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DBUILD_apps=AUTO_OFF
      -DBUILD_apps_3d_rec_framework=AUTO_OFF
      -DBUILD_apps_cloud_composer=AUTO_OFF
      -DBUILD_apps_in_hand_scanner=AUTO_OFF
      -DBUILD_apps_optronic_viewer=AUTO_OFF
      -DBUILD_apps_point_cloud_editor=AUTO_OFF
      -DBUILD_examples:BOOL=AUTO_OFF
      -DBUILD_global_tests:BOOL=OFF
      -DBUILD_outofcore:BOOL=AUTO_OFF
      -DBUILD_people:BOOL=AUTO_OFF
      -DBUILD_simulation:BOOL=AUTO_OFF
      -DWITH_CUDA:BOOL=OFF
      -DWITH_DOCS:BOOL=OFF
      -DWITH_QT:BOOL=FALSE
      -DWITH_TUTORIALS:BOOL=OFF
      -DWITH_VTK:BOOL=OFF
    ]

    if build.head?
      args << "-DBUILD_apps_modeler=AUTO_OFF"
    else
      args << "-DBUILD_apps_modeler:BOOL=OFF"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install Dir["#{bin}/*.app"]
    end
  end

  test do
    assert_match "tiff files", shell_output("#{bin}/pcl_tiff2pcd -h", 255)
  end
end
