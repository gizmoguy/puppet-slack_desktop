require 'spec_helper'
describe 'slack_desktop' do

  context 'on unsupported distributions' do
    let(:facts) {{ :osfamily => 'Unsupported' }}

    it 'it fails' do
      expect { subject.call }.to raise_error(/is not supported on an Unsupported based system/)
    end
  end

  context 'on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
      :lsbdistid => 'Debian',
      :lsbdistcodename => 'jessie'
    }}

    it 'includes slack_desktop::repo::apt' do
      should contain_class('slack_desktop::repo::apt')
    end

    it { should contain_apt__source('slack').with(
      'location'    => 'https://packagecloud.io/slacktechnologies/slack/debian/',
      'release'     => 'jessie',
      'repos'       => 'main',
      'include_src' => false,
      'key'         => '418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB'
    )}

    it { should contain_apt__key('packagecloud-slack').with(
      'key'         => 'DB085A08CA13B8ACB917E0F6D938EC0D038651BD'
    )}
  end

  ['Debian'].each do |distro|
    context "on #{distro}" do
      let(:facts) {{
        :osfamily => distro,
        :lsbdistid => distro,
        :lsbdistcodename => 'jessie',
      }}

      it { should contain_class('slack_desktop::install') }
      it { should contain_class('slack_desktop::config') }

      describe 'package installation' do
        it { should contain_package('slack-desktop').with(
          'ensure' => 'installed',
          'name'   => 'slack-desktop'
        )}
      end

      describe 'configure default file' do
        it { should contain_file('/etc/default/slack').with(
          'ensure' => 'file',
          'path'   => '/etc/default/slack'
        )}
        it 'should configure default options' do
          should contain_file('/etc/default/slack') \
            .with_content(/repo_add_once="false"/) \
            .with_content(/repo_reenable_on_distupgrade="false"/)
        end
      end
    end

    context "on #{distro}" do
      let(:facts) {{
        :osfamily => distro,
        :lsbdistid => distro,
        :lsbdistcodename => 'jessie',
      }}

      let(:params) {{
        :repo_add_once => true,
        :repo_reenable_on_distupgrade => true
      }}

      describe 'configure default file' do
        it { should contain_file('/etc/default/slack').with(
          'ensure' => 'file',
          'path'   => '/etc/default/slack'
        )}
        it 'should configure default options' do
          should contain_file('/etc/default/slack') \
            .with_content(/repo_add_once="true"/) \
            .with_content(/repo_reenable_on_distupgrade="true"/)
        end
      end
    end
  end

end
