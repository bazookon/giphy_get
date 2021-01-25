class GiphyUser {
  String? avatarUrl;
  String? bannerUrl;
  String? profileUrl;
  String? username;
  String? displayName;
  String? twitter;
  String? guid;
  String? metadataDescription;
  String? attributionDisplayName;
  String? name;
  String? description;
  String? facebookUrl;
  String? twitterUrl;
  String? instagramUrl;
  String? tumblrUrl;
  bool? suppressChrome;
  String? websiteUrl;
  String? websiteDisplayUrl;

  GiphyUser({
    this.avatarUrl,
    this.bannerUrl,
    this.profileUrl,
    this.username,
    this.displayName,
    this.twitter,
    this.guid,
    this.metadataDescription,
    this.attributionDisplayName,
    this.name,
    this.description,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.tumblrUrl,
    this.suppressChrome,
    this.websiteUrl,
    this.websiteDisplayUrl,
  });

  factory GiphyUser.fromJson(Map<String, dynamic>? json) {
    return GiphyUser(
      avatarUrl: json != null && json.containsKey('avatar_url')
          ? json['avatar_url']
          : null,
      bannerUrl: json != null && json.containsKey('banner_url')
          ? json['banner_url']
          : null,
      profileUrl: json != null && json.containsKey('profile_url')
          ? json['profile_url']
          : null,
      username: json != null && json.containsKey('username')
          ? json['username']
          : null,
      displayName: json != null && json.containsKey('display_name')
          ? json['display_name']
          : null,
      twitter:
          json != null && json.containsKey('twitter') ? json['twitter'] : null,
      guid: json != null && json.containsKey('guid') ? json['guid'] : null,
      metadataDescription:
          json != null && json.containsKey('metadata_description')
              ? json['metadata_description']
              : null,
      attributionDisplayName:
          json != null && json.containsKey('attribution_display_name')
              ? json['attribution_display_name']
              : null,
      name: json != null && json.containsKey('name') ? json['name'] : null,
      description: json != null && json.containsKey('description')
          ? json['description']
          : null,
      facebookUrl: json != null && json.containsKey('facebook_url')
          ? json['facebook_url']
          : null,
      twitterUrl: json != null && json.containsKey('twitter_url')
          ? json['twitter_url']
          : null,
      instagramUrl: json != null && json.containsKey('instagram_url')
          ? json['instagram_url']
          : null,
      tumblrUrl: json != null && json.containsKey('tumblr_url')
          ? json['tumblr_url']
          : null,
      suppressChrome: json != null && json.containsKey('suppress_chrome')
          ? json['suppress_chrome']
          : null,
      websiteUrl: json != null && json.containsKey('website_url')
          ? json['website_url']
          : null,
      websiteDisplayUrl: json != null && json.containsKey('website_display_url')
          ? json['website_display_url']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'avatar_url': avatarUrl,
      'banner_url': bannerUrl,
      'profile_url': profileUrl,
      'username': username,
      'display_name': displayName,
      'twitter': twitter,
      'guid': guid,
      'metadata_description': metadataDescription,
      'attribution_display_name': attributionDisplayName,
      'name': name,
      'description': description,
      'facebook_url': facebookUrl,
      'twitter_url': twitterUrl,
      'instagram_url': instagramUrl,
      'tumblr_url': tumblrUrl,
      'suppress_chrome': suppressChrome,
      'website_url': websiteUrl,
      'website_display_url': websiteDisplayUrl,
    };
  }

  @override
  String toString() {
    return 'GiphyUser{avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, profileUrl: $profileUrl, username: $username, displayName: $displayName, twitter: $twitter, guid: $guid, metadataDescription: $metadataDescription, attributionDisplayName: $attributionDisplayName, name: $name, description: $description, facebookUrl: $facebookUrl, twitterUrl: $twitterUrl, instagramUrl: $instagramUrl, tumblrUrl: $tumblrUrl, suppressChrome: $suppressChrome, websiteUrl: $websiteUrl, websiteDisplayUrl: $websiteDisplayUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyUser &&
          runtimeType == other.runtimeType &&
          avatarUrl == other.avatarUrl &&
          bannerUrl == other.bannerUrl &&
          profileUrl == other.profileUrl &&
          username == other.username &&
          displayName == other.displayName &&
          twitter == other.twitter &&
          guid == other.guid &&
          metadataDescription == other.metadataDescription &&
          attributionDisplayName == other.attributionDisplayName &&
          name == other.name &&
          description == other.description &&
          facebookUrl == other.facebookUrl &&
          twitterUrl == other.twitterUrl &&
          instagramUrl == other.instagramUrl &&
          tumblrUrl == other.tumblrUrl &&
          suppressChrome == other.suppressChrome &&
          websiteUrl == other.websiteUrl &&
          websiteDisplayUrl == other.websiteDisplayUrl;

  @override
  int get hashCode =>
      avatarUrl.hashCode ^
      bannerUrl.hashCode ^
      profileUrl.hashCode ^
      username.hashCode ^
      displayName.hashCode ^
      twitter.hashCode ^
      guid.hashCode ^
      metadataDescription.hashCode ^
      attributionDisplayName.hashCode ^
      name.hashCode ^
      description.hashCode ^
      facebookUrl.hashCode ^
      twitterUrl.hashCode ^
      instagramUrl.hashCode ^
      tumblrUrl.hashCode ^
      suppressChrome.hashCode ^
      websiteUrl.hashCode ^
      websiteDisplayUrl.hashCode;
}
