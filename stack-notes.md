#[CloudFormation Samples](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-sample-templates.html)

## Region is very important, AMI is only available in its own region. Same as all the other resources.

`Fn::Base64` is used to encrypted later command into Base64 format
[intrinsic-function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)

```
groupadd -g 1000 jenkins
useradd -u 1000 -g jenkins jenkins
```
These command creates a jenkins uid/gid on the ECS Host that matches the jenkins container uid/gid, in other words,
the container image we pull from AMI already has jenkins uid/gid, and we need to create uid/gid for jenkins in the EC2
instance to match it.

### EC2InstanceSecurityGroup:
[SecurityGroupIngress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group-rule.html)
```
Enable HTTP access on the configured port
{
  "IpProtocol":"tcp",
  "FromPort":"8080",
  "ToPort":"8080",
  "SourceSecurityGroupId" : "{ 'Ref': 'ElbSecurityGroup' }"
},
Enable SSH access via port 22
{
  "IpProtocol":"tcp",
  "FromPort":"22",
  "ToPort":"22",
  "CidrIP":"0.0.0.0/0"
},

```


### EC2InstanceRole:
1. AmazonEC2ContainerServiceforEC2Role: use this Role to allow EC2 instance to join in a ECS cluster and run ECS Services
and Tasks.
2. `EC2InstanceRole` is just a name, what matters is the `Type` defined latter.
3. Each resource defined in the AWS-CloudFormation has `Type` and `Properties` parameters.
[AWS::IAM::Role properties](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html#w2ab1c21c10d133c37c11)
4. `AssumeRolePolicyDocument`: The trust policy that is associated with this role.
[IAM document policy elements](https://docs.aws.amazon.com//IAM/latest/UserGuide/reference_policies_elements.html)
#### JSON document policy is made up by elements
1. [principal](https://docs.aws.amazon.com//IAM/latest/UserGuide/reference_policies_elements_principal.html)
2. [action](https://docs.aws.amazon.com//IAM/latest/UserGuide/reference_policies_elements_action.html)
`"Action":[sts:AssumeRole]` this action is be executed by the service of sts(AWS security token service) on [AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html)

### Elastic Load Balancer:
[AWS Elastic Load Balancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb.html)
**Define a security and then the actual elastic load balancer**
1. `LoadBalancePort`: Github and Dockerhub use this port to connect with Elastic Load Balancer
2. `InstancePort`: Jenkins EC2 instance use this port to connect with Elastic Load Balancer
3. `Listener`: This is a required property [ElasticLoadBalcing::Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb-listener.html)

### Elastic Container Service:
[Elastic Container Service TaskDefinition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html)

### Cloudformation outputs:
[Template Anatomy: Outputs](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/outputs-section-structure.html)

`chmod 600 ~/.ssh/jenkins-admin.pem`: update the file mode to avoid ssh security restrictions