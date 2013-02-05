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
Requires:	    ruby(abi) = 1.9.1

%global         entrydns_root   /srv/%{name}

%description
EntryDNS delivers a totally free DNS management service for your enjoyment.
Our aim is to provide a friendly and caring, yet powerful service for your
DNS needs.


%prep
%setup -q


%build
bundle install --path vendor/ --without development test
# clean not required files and directories
rm -rf test doc spec Capfile Gemfile Gemfile.lock Guardfile Rakefile .git


%install
rm -rf %{buildroot}

install -p -d -m 0755 %{buildroot}%{entrydns_root}
cp -R . %{buildroot}%{entrydns_root}


%files
%doc



%changelog

