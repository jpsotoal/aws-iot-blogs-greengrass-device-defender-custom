# AWS IoT Greengrass Device Defender Component example with custom metrics implementation

This is the artifacts repository for the blog post **How to use AWS IoT Device Defender Custom Metrics to detect cryptocurrency mining threats on IoT edge computers**

## Installation

```
chmod +x build.sh
./build.sh
```

`build.sh` shell script clones [aws-greengrass/aws-greengrass-device-defender](https://github.com/aws-greengrass/aws-greengrass-device-defender) and [aws-samples/aws-iot-device-defender-agent-sdk-python](https://github.com/aws-samples/aws-iot-device-defender-agent-sdk-python) repositories as the base. Then, it applies patch files under `patch/` folder for the custom metrics implementation.
## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.