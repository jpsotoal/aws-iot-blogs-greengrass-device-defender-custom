#!/bin/bash
git clone git@github.com:aws-greengrass/aws-greengrass-device-defender.git com.awsiotblog.DeviceDefenderCustom
cd com.awsiotblog.DeviceDefenderCustom
git checkout a804600917a08ce3ada5eab0744bb1f8c97857c8

git clone git@github.com:aws-samples/aws-iot-device-defender-agent-sdk-python.git greengrass_defender_agent/AWSIoTDeviceDefenderAgentSDK
cd greengrass_defender_agent/AWSIoTDeviceDefenderAgentSDK
git checkout a3d27c51311e12625bd0b774e8b730ead3bc515d
git apply ../../../patches/patches_aws-iot-device-defender-agent-sdk-python.patch

cd ../..
git apply ../patches/patches_aws-greengrass-device-defender.patch
