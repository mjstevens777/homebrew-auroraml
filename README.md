# homebrew-auroraml

## pcl

To update the bottle:
```
brew install --debug --verbose --build-bottle mjstevens777/auroraml/pcl
brew bottle --verbose pcl
# Update pcl.rb with new sha256 printed at the end of the bottle command
aws s3 cp --acl public-read pcl-1.8.1_3.high_sierra.bottle.1.tar.gz s3://aurorasolar-envision/homebrew/pcl-1.8.1_3.high_sierra.bottle.1.tar.gz
```

```
brew install --debug --verbose --build-bottle mjstevens777/auroraml/pdal
brew bottle --verbose pdal
# Update pdal.rb with new sha256 printed at the end of the bottle command
aws s3 cp --acl public-read pdal-VERSION.high_sierra.bottle.1.tar.gz s3://aurorasolar-envision/homebrew/pcl-VERSION.high_sierra.bottle.1.tar.gz
```
