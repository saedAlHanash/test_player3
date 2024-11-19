class DailymotionResponse {
  DailymotionResponse({
    required this.url,
    required this.filmstripUrl,
    required this.protectedDelivery,
    required this.channel,
    required this.createdTime,
    required this.detectedLanguage,
    required this.duration,
    required this.explicit,
    required this.hasPaidPartnership,
    required this.id,
    required this.isCreatedForKids,
    required this.language,
    required this.mediaType,
    required this.partner,
    required this.liveShowViewers,
    required this.seekerUrl,
    required this.tags,
    required this.title,
    required this.verified,
    required this.mode,
    required this.private,
    required this.dataCenter,
    required this.viewId,
    required this.accessId,
    required this.isPasswordProtected,
    required this.advertising,
    required this.thumbnails,
    required this.firstFrames,
    required this.owner,
    required this.watermark,
    required this.qualities,
    required this.reporting,
    required this.sharing,
    required this.streamType,
    required this.subtitles,
    required this.info,
    required this.consent,
  });

  final String url;
  final String filmstripUrl;
  final bool protectedDelivery;
  final String channel;
  final num createdTime;
  final String detectedLanguage;
  final num duration;
  final bool explicit;
  final bool hasPaidPartnership;
  final String id;
  final bool isCreatedForKids;
  final String language;
  final String mediaType;
  final bool partner;
  final bool liveShowViewers;
  final String seekerUrl;
  final List<dynamic> tags;
  final String title;
  final bool verified;
  final String mode;
  final bool private;
  final String dataCenter;
  final String viewId;
  final String accessId;
  final bool isPasswordProtected;
  final Advertising? advertising;
  final Map<String, String> thumbnails;
  final Map<String, String> firstFrames;
  final Owner? owner;
  final Watermark? watermark;
  final Qualities? qualities;
  final Reporting? reporting;
  final dynamic sharing;
  final String streamType;
  final Subtitles? subtitles;
  final Info? info;
  final Consent? consent;

  factory DailymotionResponse.fromJson(Map<String, dynamic> json) {
    return DailymotionResponse(
      url: json["url"] ?? "",
      filmstripUrl: json["filmstrip_url"] ?? "",
      protectedDelivery: json["protected_delivery"] ?? false,
      channel: json["channel"] ?? "",
      createdTime: json["created_time"] ?? 0,
      detectedLanguage: json["detected_language"] ?? "",
      duration: json["duration"] ?? 0,
      explicit: json["explicit"] ?? false,
      hasPaidPartnership: json["has_paid_partnership"] ?? false,
      id: json["id"] ?? "",
      isCreatedForKids: json["is_created_for_kids"] ?? false,
      language: json["language"] ?? "",
      mediaType: json["media_type"] ?? "",
      partner: json["partner"] ?? false,
      liveShowViewers: json["live_show_viewers"] ?? false,
      seekerUrl: json["seeker_url"] ?? "",
      tags: json["tags"] == null
          ? []
          : List<dynamic>.from(json["tags"]!.map((x) => x)),
      title: json["title"] ?? "",
      verified: json["verified"] ?? false,
      mode: json["mode"] ?? "",
      private: json["private"] ?? false,
      dataCenter: json["data_center"] ?? "",
      viewId: json["view_id"] ?? "",
      accessId: json["access_id"] ?? "",
      isPasswordProtected: json["is_password_protected"] ?? false,
      advertising: json["advertising"] == null
          ? null
          : Advertising.fromJson(json["advertising"]),
      thumbnails: Map.from(json["thumbnails"])
          .map((k, v) => MapEntry<String, String>(k, v)),
      firstFrames: Map.from(json["first_frames"])
          .map((k, v) => MapEntry<String, String>(k, v)),
      owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      watermark: json["watermark"] == null
          ? null
          : Watermark.fromJson(json["watermark"]),
      qualities: json["qualities"] == null
          ? null
          : Qualities.fromJson(json["qualities"]),
      reporting: json["reporting"] == null
          ? null
          : Reporting.fromJson(json["reporting"]),
      sharing: json["sharing"],
      streamType: json["stream_type"] ?? "",
      subtitles: json["subtitles"] == null
          ? null
          : Subtitles.fromJson(json["subtitles"]),
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
      consent:
          json["consent"] == null ? null : Consent.fromJson(json["consent"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "filmstrip_url": filmstripUrl,
        "protected_delivery": protectedDelivery,
        "channel": channel,
        "created_time": createdTime,
        "detected_language": detectedLanguage,
        "duration": duration,
        "explicit": explicit,
        "has_paid_partnership": hasPaidPartnership,
        "id": id,
        "is_created_for_kids": isCreatedForKids,
        "language": language,
        "media_type": mediaType,
        "partner": partner,
        "live_show_viewers": liveShowViewers,
        "seeker_url": seekerUrl,
        "tags": tags.map((x) => x).toList(),
        "title": title,
        "verified": verified,
        "mode": mode,
        "private": private,
        "data_center": dataCenter,
        "view_id": viewId,
        "access_id": accessId,
        "is_password_protected": isPasswordProtected,
        "advertising": advertising?.toJson(),
        "thumbnails":
            Map.from(thumbnails).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "first_frames": Map.from(firstFrames)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "owner": owner?.toJson(),
        "watermark": watermark?.toJson(),
        "qualities": qualities?.toJson(),
        "reporting": reporting?.toJson(),
        "sharing": sharing,
        "stream_type": streamType,
        "subtitles": subtitles?.toJson(),
        "info": info?.toJson(),
        "consent": consent?.toJson(),
      };
}

class Advertising {
  Advertising({
    required this.adUrl,
    required this.adErrorUrl,
    required this.adSyncScriptUrl,
    required this.ima,
  });

  final String adUrl;
  final String adErrorUrl;
  final String adSyncScriptUrl;
  final Info? ima;

  factory Advertising.fromJson(Map<String, dynamic> json) {
    return Advertising(
      adUrl: json["ad_url"] ?? "",
      adErrorUrl: json["ad_error_url"] ?? "",
      adSyncScriptUrl: json["ad_sync_script_url"] ?? "",
      ima: json["ima"] == null ? null : Info.fromJson(json["ima"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "ad_url": adUrl,
        "ad_error_url": adErrorUrl,
        "ad_sync_script_url": adSyncScriptUrl,
        "ima": ima?.toJson(),
      };
}

class Info {
  Info({
    required this.enable,
  });

  final bool enable;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      enable: json["enable"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "enable": enable,
      };
}

class Consent {
  Consent({required this.json});

  final Map<String, dynamic> json;

  factory Consent.fromJson(Map<String, dynamic> json) {
    return Consent(json: json);
  }

  Map<String, dynamic> toJson() => {};
}

class Owner {
  Owner({
    required this.id,
    required this.parentId,
    required this.screenname,
    required this.url,
    required this.username,
    required this.avatars,
    required this.type,
    required this.watermarkImageUrl,
    required this.watermarkLinkUrl,
  });

  final String id;
  final dynamic parentId;
  final String screenname;
  final String url;
  final String username;
  final Avatars? avatars;
  final String type;
  final dynamic watermarkImageUrl;
  final dynamic watermarkLinkUrl;

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json["id"] ?? "",
      parentId: json["parent_id"],
      screenname: json["screenname"] ?? "",
      url: json["url"] ?? "",
      username: json["username"] ?? "",
      avatars:
          json["avatars"] == null ? null : Avatars.fromJson(json["avatars"]),
      type: json["type"] ?? "",
      watermarkImageUrl: json["watermark_image_url"],
      watermarkLinkUrl: json["watermark_link_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "screenname": screenname,
        "url": url,
        "username": username,
        "avatars": avatars?.toJson(),
        "type": type,
        "watermark_image_url": watermarkImageUrl,
        "watermark_link_url": watermarkLinkUrl,
      };
}

class Avatars {
  Avatars({
    required this.the60,
  });

  final String the60;

  factory Avatars.fromJson(Map<String, dynamic> json) {
    return Avatars(
      the60: json["60"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "60": the60,
      };
}

class Qualities {
  Qualities({
    required this.auto,
  });

  final List<Auto> auto;

  factory Qualities.fromJson(Map<String, dynamic> json) {
    return Qualities(
      auto: json["auto"] == null
          ? []
          : List<Auto>.from(json["auto"]!.map((x) => Auto.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "auto": auto.map((x) => x?.toJson()).toList(),
      };
}

class Auto {
  Auto({
    required this.type,
    required this.url,
  });

  final String type;
  final String url;

  factory Auto.fromJson(Map<String, dynamic> json) {
    return Auto(
      type: json["type"] ?? "",
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}

class Reporting {
  Reporting({
    required this.enable,
    required this.tracking,
    required this.ias,
    required this.comScore,
  });

  final bool enable;
  final Tracking? tracking;
  final Ias? ias;
  final ComScore? comScore;

  factory Reporting.fromJson(Map<String, dynamic> json) {
    return Reporting(
      enable: json["enable"] ?? false,
      tracking:
          json["tracking"] == null ? null : Tracking.fromJson(json["tracking"]),
      ias: json["ias"] == null ? null : Ias.fromJson(json["ias"]),
      comScore:
          json["comScore"] == null ? null : ComScore.fromJson(json["comScore"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "tracking": tracking?.toJson(),
        "ias": ias?.toJson(),
        "comScore": comScore?.toJson(),
      };
}

class ComScore {
  ComScore({
    required this.c2,
    required this.c3,
    required this.c4,
  });

  final String c2;
  final String c3;
  final String c4;

  factory ComScore.fromJson(Map<String, dynamic> json) {
    return ComScore(
      c2: json["c2"] ?? "",
      c3: json["c3"] ?? "",
      c4: json["c4"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "c2": c2,
        "c3": c3,
        "c4": c4,
      };
}

class Ias {
  Ias({
    required this.anid,
    required this.partner,
  });

  final String anid;
  final String partner;

  factory Ias.fromJson(Map<String, dynamic> json) {
    return Ias(
      anid: json["anid"] ?? "",
      partner: json["partner"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "anid": anid,
        "partner": partner,
      };
}

class Tracking {
  Tracking({
    required this.history,
    required this.history8010M,
    required this.internal,
  });

  final String history;
  final String history8010M;
  final String internal;

  factory Tracking.fromJson(Map<String, dynamic> json) {
    return Tracking(
      history: json["history"] ?? "",
      history8010M: json["history@80%|10m"] ?? "",
      internal: json["internal"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "history": history,
        "history@80%|10m": history8010M,
        "internal": internal,
      };
}

class Subtitles {
  Subtitles({
    required this.enable,
    required this.data,
  });

  final bool enable;
  final List<dynamic> data;

  factory Subtitles.fromJson(Map<String, dynamic> json) {
    return Subtitles(
      enable: json["enable"] ?? false,
      data: json["data"] == null
          ? []
          : List<dynamic>.from(json["data"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "data": data.map((x) => x).toList(),
      };
}

class Watermark {
  Watermark({
    required this.imageUrl,
    required this.linkUrl,
  });

  final dynamic imageUrl;
  final dynamic linkUrl;

  factory Watermark.fromJson(Map<String, dynamic> json) {
    return Watermark(
      imageUrl: json["image_url"],
      linkUrl: json["link_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "link_url": linkUrl,
      };
}
