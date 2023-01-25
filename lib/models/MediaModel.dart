class MediaModel {
    String? alt_text;
    int? author;
    Caption? caption;
    String? comment_status;
    String? date;
    String? date_gmt;
    Description? description;
    Guid? guid;
    int? id;
    String? link;
    Links? links;
    MediaDetails? media_details;
    String? media_type;
    String? mime_type;
    String? modified;
    String? modified_gmt;
    String? ping_status;
    String? slug;
    String? source_url;
    String? status;
    String? template;
    Title? title;
    String? type;

    MediaModel({this.alt_text, this.author, this.caption, this.comment_status, this.date, this.date_gmt, this.description, this.guid, this.id, this.link, this.links, this.media_details, this.media_type, this.mime_type, this.modified, this.modified_gmt, this.ping_status, this.slug, this.source_url, this.status, this.template, this.title, this.type});

    factory MediaModel.fromJson(Map<String, dynamic> json) {
        return MediaModel(
            alt_text: json['alt_text'], 
            author: json['author'], 
            caption: json['caption'] != null ? Caption.fromJson(json['caption']) : null, 
            comment_status: json['comment_status'], 
            date: json['date'], 
            date_gmt: json['date_gmt'], 
            description: json['description'] != null ? Description.fromJson(json['description']) : null, 
            guid: json['guid'] != null ? Guid.fromJson(json['guid']) : null, 
            id: json['id'], 
            link: json['link'], 
            links: json['links'] != null ? Links.fromJson(json['links']) : null, 
            media_details: json['media_details'] != null ? MediaDetails.fromJson(json['media_details']) : null, 
            media_type: json['media_type'], 
            mime_type: json['mime_type'], 
            modified: json['modified'], 
            modified_gmt: json['modified_gmt'], 
            ping_status: json['ping_status'], 
            slug: json['slug'], 
            source_url: json['source_url'], 
            status: json['status'], 
            template: json['template'], 
            title: json['title'] != null ? Title.fromJson(json['title']) : null, 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alt_text'] = this.alt_text;
        data['author'] = this.author;
        data['comment_status'] = this.comment_status;
        data['date'] = this.date;
        data['date_gmt'] = this.date_gmt;
        data['id'] = this.id;
        data['link'] = this.link;
        data['media_type'] = this.media_type;
        data['mime_type'] = this.mime_type;
        data['modified'] = this.modified;
        data['modified_gmt'] = this.modified_gmt;
        data['ping_status'] = this.ping_status;
        data['slug'] = this.slug;
        data['source_url'] = this.source_url;
        data['status'] = this.status;
        data['template'] = this.template;
        data['type'] = this.type;
        if (this.caption != null) {
            data['caption'] = this.caption!.toJson();
        }
        if (this.description != null) {
            data['description'] = this.description!.toJson();
        }
        if (this.guid != null) {
            data['guid'] = this.guid!.toJson();
        }
        if (this.links != null) {
            data['links'] = this.links!.toJson();
        }
        if (this.media_details != null) {
            data['media_details'] = this.media_details!.toJson();
        }
        if (this.title != null) {
            data['title'] = this.title!.toJson();
        }
        return data;
    }
}

class Guid {
    String? rendered;

    Guid({this.rendered});

    factory Guid.fromJson(Map<String, dynamic> json) {
        return Guid(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}

class MediaDetails {
    String? file;
    int? height;
    ImageMeta? image_meta;
    Sizes? sizes;
    int? width;

    MediaDetails({this.file, this.height, this.image_meta, this.sizes, this.width});

    factory MediaDetails.fromJson(Map<String, dynamic> json) {
        return MediaDetails(
            file: json['`file`'],
            height: json['height'], 
            image_meta: json['image_meta'] != null ? ImageMeta.fromJson(json['image_meta']) : null, 
            sizes: json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null, 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['width'] = this.width;
        if (this.image_meta != null) {
            data['image_meta'] = this.image_meta!.toJson();
        }
        if (this.sizes != null) {
            data['sizes'] = this.sizes!.toJson();
        }
        return data;
    }
}

class ImageMeta {
    String? aperture;
    String? camera;
    String? caption;
    String? copyright;
    String? created_timestamp;
    String? credit;
    String? focal_length;
    String? iso;
    String? orientation;
    String? shutter_speed;
    String? title;

    ImageMeta({this.aperture, this.camera, this.caption, this.copyright, this.created_timestamp, this.credit, this.focal_length, this.iso, this.orientation, this.shutter_speed, this.title});

    factory ImageMeta.fromJson(Map<String, dynamic> json) {
        return ImageMeta(
            aperture: json['aperture'], 
            camera: json['camera'], 
            caption: json['caption'], 
            copyright: json['copyright'], 
            created_timestamp: json['created_timestamp'], 
            credit: json['credit'], 
            focal_length: json['focal_length'], 
            iso: json['iso'], 
            orientation: json['orientation'], 
            shutter_speed: json['shutter_speed'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aperture'] = this.aperture;
        data['camera'] = this.camera;
        data['caption'] = this.caption;
        data['copyright'] = this.copyright;
        data['created_timestamp'] = this.created_timestamp;
        data['credit'] = this.credit;
        data['focal_length'] = this.focal_length;
        data['iso'] = this.iso;
        data['orientation'] = this.orientation;
        data['shutter_speed'] = this.shutter_speed;
        data['title'] = this.title;
        return data;
    }
}

class Sizes {
    Full? full;
    WoocommerceGalleryThumbnail? woocommerce_gallery_thumbnail;
    WoocommerceSingle? woocommerce_single;
    WoocommerceThumbnail? woocommerce_thumbnail;

    Sizes({this.full, this.woocommerce_gallery_thumbnail, this.woocommerce_single, this.woocommerce_thumbnail});

    factory Sizes.fromJson(Map<String, dynamic> json) {
        return Sizes(
            full: json['full'] != null ? Full.fromJson(json['full']) : null, 
            woocommerce_gallery_thumbnail: json['woocommerce_gallery_thumbnail'] != null ? WoocommerceGalleryThumbnail.fromJson(json['woocommerce_gallery_thumbnail']) : null, 
            woocommerce_single: json['woocommerce_single'] != null ? WoocommerceSingle.fromJson(json['woocommerce_single']) : null, 
            woocommerce_thumbnail: json['woocommerce_thumbnail'] != null ? WoocommerceThumbnail.fromJson(json['woocommerce_thumbnail']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.full != null) {
            data['full'] = this.full!.toJson();
        }
        if (this.woocommerce_gallery_thumbnail != null) {
            data['woocommerce_gallery_thumbnail'] = this.woocommerce_gallery_thumbnail!.toJson();
        }
        if (this.woocommerce_single != null) {
            data['woocommerce_single'] = this.woocommerce_single!.toJson();
        }
        if (this.woocommerce_thumbnail != null) {
            data['woocommerce_thumbnail'] = this.woocommerce_thumbnail!.toJson();
        }
        return data;
    }
}

class Full {
    String? file;
    int? height;
    String? mime_type;
    String? source_url;
    int? width;

    Full({this.file, this.height, this.mime_type, this.source_url, this.width});

    factory Full.fromJson(Map<String, dynamic> json) {
        return Full(
            file: json['`file`'],
            height: json['height'], 
            mime_type: json['mime_type'], 
            source_url: json['source_url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mime_type;
        data['source_url'] = this.source_url;
        data['width'] = this.width;
        return data;
    }
}

class WoocommerceGalleryThumbnail {
    String? file;
    int? height;
    String? mime_type;
    String? source_url;
    int? width;

    WoocommerceGalleryThumbnail({this.file, this.height, this.mime_type, this.source_url, this.width});

    factory WoocommerceGalleryThumbnail.fromJson(Map<String, dynamic> json) {
        return WoocommerceGalleryThumbnail(
            file: json['`file`'],
            height: json['height'], 
            mime_type: json['mime_type'], 
            source_url: json['source_url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mime_type;
        data['source_url'] = this.source_url;
        data['width'] = this.width;
        return data;
    }
}

class WoocommerceSingle {
    String? file;
    int? height;
    String? mime_type;
    String? source_url;
    int? width;

    WoocommerceSingle({this.file, this.height, this.mime_type, this.source_url, this.width});

    factory WoocommerceSingle.fromJson(Map<String, dynamic> json) {
        return WoocommerceSingle(
            file: json['`file`'],
            height: json['height'], 
            mime_type: json['mime_type'], 
            source_url: json['source_url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mime_type;
        data['source_url'] = this.source_url;
        data['width'] = this.width;
        return data;
    }
}

class WoocommerceThumbnail {
    String? file;
    int? height;
    String? mime_type;
    String? source_url;
    bool? uncropped;
    int? width;

    WoocommerceThumbnail({this.file, this.height, this.mime_type, this.source_url, this.uncropped, this.width});

    factory WoocommerceThumbnail.fromJson(Map<String, dynamic> json) {
        return WoocommerceThumbnail(
            file: json['`file`'],
            height: json['height'], 
            mime_type: json['mime_type'], 
            source_url: json['source_url'], 
            uncropped: json['uncropped'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mime_type;
        data['source_url'] = this.source_url;
        data['uncropped'] = this.uncropped;
        data['width'] = this.width;
        return data;
    }
}

class Caption {
    String? rendered;

    Caption({this.rendered});

    factory Caption.fromJson(Map<String, dynamic> json) {
        return Caption(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}

class Links {
    List<About>? about;
    List<Author>? author;
    List<Collection>? collection;
    List<Reply>? replies;
    List<Self>? self;

    Links({this.about, this.author, this.collection, this.replies, this.self});

    factory Links.fromJson(Map<String, dynamic> json) {
        return Links(
            about: json['about'] != null ? (json['about'] as List).map((i) => About.fromJson(i)).toList() : null, 
            author: json['author'] != null ? (json['author'] as List).map((i) => Author.fromJson(i)).toList() : null, 
            collection: json['collection'] != null ? (json['collection'] as List).map((i) => Collection.fromJson(i)).toList() : null, 
            replies: json['replies'] != null ? (json['replies'] as List).map((i) => Reply.fromJson(i)).toList() : null, 
            self: json['self'] != null ? (json['self'] as List).map((i) => Self.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.about != null) {
            data['about'] = this.about!.map((v) => v.toJson()).toList();
        }
        if (this.author != null) {
            data['author'] = this.author!.map((v) => v.toJson()).toList();
        }
        if (this.collection != null) {
            data['collection'] = this.collection!.map((v) => v.toJson()).toList();
        }
        if (this.replies != null) {
            data['replies'] = this.replies!.map((v) => v.toJson()).toList();
        }
        if (this.self != null) {
            data['self'] = this.self!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Collection {
    String? href;

    Collection({this.href});

    factory Collection.fromJson(Map<String, dynamic> json) {
        return Collection(
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['href'] = this.href;
        return data;
    }
}

class About {
    String? href;

    About({this.href});

    factory About.fromJson(Map<String, dynamic> json) {
        return About(
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['href'] = this.href;
        return data;
    }
}

class Author {
    bool? embeddable;
    String? href;

    Author({this.embeddable, this.href});

    factory Author.fromJson(Map<String, dynamic> json) {
        return Author(
            embeddable: json['embeddable'], 
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['embeddable'] = this.embeddable;
        data['href'] = this.href;
        return data;
    }
}

class Self {
    String? href;

    Self({this.href});

    factory Self.fromJson(Map<String, dynamic> json) {
        return Self(
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['href'] = this.href;
        return data;
    }
}

class Reply {
    bool? embeddable;
    String? href;

    Reply({this.embeddable, this.href});

    factory Reply.fromJson(Map<String, dynamic> json) {
        return Reply(
            embeddable: json['embeddable'], 
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['embeddable'] = this.embeddable;
        data['href'] = this.href;
        return data;
    }
}

class Description {
    String? rendered;

    Description({this.rendered});

    factory Description.fromJson(Map<String, dynamic> json) {
        return Description(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}

class Title {
    String? rendered;

    Title({this.rendered});

    factory Title.fromJson(Map<String, dynamic> json) {
        return Title(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}