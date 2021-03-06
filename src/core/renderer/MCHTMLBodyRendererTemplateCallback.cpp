//
//  MCHTMLBodyRendererTemplateCallback.cc
//  mailcore2
//
//  Created by Paul Young on 02/07/2013.
//  Copyright (c) 2013 MailCore. All rights reserved.
//

#include "MCHTMLBodyRendererTemplateCallback.h"

using namespace mailcore;

mailcore::String * HTMLBodyRendererTemplateCallback::templateForMainHeader(MessageHeader * header)
{
    return MCSTR("");
}

mailcore::String * HTMLBodyRendererTemplateCallback::templateForMessage(AbstractMessage * message)
{
    return MCSTR("{{BODY}}");
}

mailcore::String * HTMLBodyRendererTemplateCallback::templateForEmbeddedMessage(AbstractMessagePart * part)
{
    return MCSTR("{{BODY}}");
}

mailcore::String * HTMLBodyRendererTemplateCallback::templateForAttachment(AbstractPart * part)
{
    return MCSTR("");
}

mailcore::String * HTMLBodyRendererTemplateCallback::templateForAttachmentSeparator()
{
    return MCSTR("");
}
