# frozen_string_literal: true

module AwsResources
  def s3
    @s3 ||= AWS::S3.new
  end

  def r53
    @r53 ||= AWS::Route53.new
  end

  def sqs
    @sqs ||= AWS::SQS.new
  end

  def sns
    @sns ||= AWS::SNS.new(region: 'us-east-1')
  end

  def topic
    sns.topics[ENV['AWS_TOPIC_NAME']]
  end

  def queue
    sqs.queues[ENV['AWS_QUEUE_NAME']]
  end
end
