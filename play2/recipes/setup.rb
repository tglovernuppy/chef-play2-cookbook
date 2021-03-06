#
# Cookbook Name:: play2
# Recipe:: setup
#

include_recipe "java"

package 'git'

url     = node[:play2][:url]
version = node[:play2][:version]
activator_version = node[:play2][:activator_version]

artifact_deploy "play2" do
  version node[:play2][:version]
  artifact_location "#{url}/#{activator_version}/typesafe-activator-#{activator_version}-minimal.zip"

  deploy_to node[:play2][:deploy_to] || "/opt/play"
  shared_directories []

  owner "root"
  group "root"

#  after_deploy Proc.new {
#    link "/usr/bin/play" do
#      to "#{release_path}/play-#{version}/play"
#    end
#  }

  after_deploy Proc.new {
    link "/usr/bin/activator" do
      to "#{release_path}/activator-#{activator_version}-minimal/activator"
    end
  }

  action :nothing if Chef::Artifact.get_current_deployed_version(deploy_to) == version
end