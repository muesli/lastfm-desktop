/*
   Copyright 2005-2009 Last.fm Ltd. 
      - Primarily authored by Jono Cole and Doug Mansell

   This file is part of the Last.fm Desktop Application Suite.

   lastfm-desktop is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   lastfm-desktop is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with lastfm-desktop.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "ScrobbleControls.h"
#include "Application.h"

#include <QHBoxLayout>
#include <QPushButton>

ScrobbleControls::ScrobbleControls()
{
    new QHBoxLayout( this );
    QPushButton* b;
    layout()->addWidget(b = new QPushButton(tr("love")));
    b->setObjectName("love");
    b->addAction( ((audioscrobbler::Application*)qApp)->loveAction() );
    b->setAutoFillBackground( true );
    
    layout()->addWidget(b = new QPushButton(tr("tag")));
    b->setObjectName("tag");
    b->addAction( ((audioscrobbler::Application*)qApp)->tagAction() );
    
    layout()->addWidget(b = new QPushButton(tr("share")));
    b->setObjectName("share");
    b->addAction( ((audioscrobbler::Application*)qApp)->shareAction() );
}
