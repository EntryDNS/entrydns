%global _enable_debug_package   0
%global debug_package           %{nil}
%global __os_install_post       /usr/lib/rpm/brp-compress %{nil}
%global app_root                /srv/entrydns

Name:           entrydns
Version:        0.0.2
Release:        1%{?dist}
Summary:        Free DNS management service for everyone

Group:          Applications/Internet
License:        AGPL
URL:            https://entrydns.net
Source0:        %{name}-%{version}.tar.gz
BuildArch:      x86_64

BuildRequires:  ruby(abi) = 1.9.1
BuildRequires:  rubygems >= 1.8
BuildRequires:  ruby-devel >= 1.9.3
BuildRequires:  mysql-devel >= 5.5
BuildRequires:  rubygems-devel >= 1.8
BuildRequires:  libxml2-devel
BuildRequires:  libxslt-devel
BuildRequires:	rubygem-rake >= 0.9.6
#BuildRequires:	rubygem-therubyracer >= 0.10.2
#BuildRequires:	rubygem-compass >= 0.12.2
#BuildRequires:	rubygem-sass-rails >= 3.2.5
Requires:	    ruby(abi) = 1.9.1
Requires:	    rubygem-nokogiri >= 0.3.3
Requires:	    rubygem-tzinfo >= 0.3.29
Requires:	    rubygem-erubis >= 2.1.7
Requires:	    rubygem-rdoc >= 3.12
Requires:	    rubygem-rake >= 0.9.6
Requires:	    rubygem-rack >= 1.4.0


%description
EntryDNS delivers a totally free DNS management service for your enjoyment.
Our aim is to provide a friendly and caring, yet powerful service for your
DNS needs.


%prep
%setup -q


%build
bundle install --path assests_tmp/ --without development test production
bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile
bundle install --path vendor/ --without development test


%install
# clean not required files and directories
rm -rf test doc spec Capfile Gemfile Gemfile.lock Guardfile Rakefile .git \
    .bundle .gitignore .rspec .rvmrc vendor/ruby/1.9.1/cache/*

find vendor/ -type f -wholename "*/cache/*.gem" -delete
find . -type f -name ".git*" -delete

install -p -d -m 0755 %{buildroot}%{app_root}
install -p -d -m 0755 %{buildroot}%{app_root}/log
cp -R app %{buildroot}%{app_root}
cp -R config %{buildroot}%{app_root}
cp -R db %{buildroot}%{app_root}
cp -R lib %{buildroot}%{app_root}
cp -R public %{buildroot}%{app_root}
cp -R script %{buildroot}%{app_root}
cp -R vendor %{buildroot}%{app_root}
cp config.ru %{buildroot}%{app_root}


%files
%{app_root}/app
%{app_root}/config
%{app_root}/db
%{app_root}/lib
%{app_root}/log/
%{app_root}/public
%{app_root}/script
%{app_root}/vendor
%{app_root}/config.ru


%changelog
* Tue Feb 5 2013 Vaidas Jablonskis <jablonskis@gmail.com> - 1:0.0.2-1
- initial build
