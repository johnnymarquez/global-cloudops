#!/usr/bin/env node
import * as cdk from aws-cdk-lib;
import { MicroserviceStack } from ../lib/microservice-stack;

const app = new cdk.App();

new MicroserviceStack(app, MicroserviceStack-us-east-1, {
  env: { region: us-east-1 },
});

new MicroserviceStack(app, MicroserviceStack-eu-west-1, {
  env: { region: eu-west-1 },
});

