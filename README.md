# homebrew-auroraml

For easier development, work in the directory `/usr/local/Homebrew/Library/Taps/mjstevens777/homebrew-auroraml` after first pulling the tap.

## pcl

To update the bottle:

```
brew install --debug --verbose --build-bottle mjstevens777/auroraml/pcl
brew bottle --verbose pcl
# Update pcl.rb with new sha256 printed at the end of the bottle command
aws s3 cp --acl public-read pcl-1.8.1_3.high_sierra.bottle.1.tar.gz s3://aurorasolar-envision/homebrew/pcl-1.8.1_3.high_sierra.bottle.1.tar.gz
```

## pdal

```
brew install --debug --verbose --build-bottle mjstevens777/auroraml/pdal
brew bottle --verbose pdal
# Update pdal.rb with new sha256 printed at the end of the bottle command
aws s3 cp --acl public-read pdal*.high_sierra.bottle.tar.gz s3://aurorasolar-envision/homebrew/pdal-1.7.2.rc1.high_sierra.bottle.1.tar.gz
```
