//////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
//////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software Foundation,
// Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//////////////////////////////////////////////////////////////////////

#ifndef __OTSERV_NETWORK_MESSAGE_H__
#define __OTSERV_NETWORK_MESSAGE_H__

#include "definitions.h"
#include "otsystem.h"
#include "const.h"
#include <string>
#include <boost/shared_ptr.hpp>

class Item;
class Creature;
class Player;
class Position;
class RSA;

class NetworkMessage
{
public:
	enum { header_length = 2 };
	enum { max_body_length = NETWORKMESSAGE_MAXSIZE - header_length };

	// constructor/destructor
	NetworkMessage(){
		reset();
	}
	virtual ~NetworkMessage(){};

	// resets the internal buffer to an empty message
protected:
	void reset(){
		m_overrun = false;
		m_priorize = false;
		m_MsgSize = 0;
		m_ReadPos = 4;
	}
public:
	void priorize() {
		m_priorize = true;
	}

	// simply read functions for incoming message
	uint8_t getByte(){
		if(!expectRead(1)){
			return 0;
		}
		
		return m_MsgBuf[m_ReadPos++];
	}

#ifndef __SWAP_ENDIAN__
	uint16_t getU16(){
		if(!expectRead(2)){
			return 0;
		}
		
		uint16_t v = *(uint16_t*)(m_MsgBuf + m_ReadPos);
		m_ReadPos += 2;
		return v;
	}
	uint32_t getU32(){
		if(!expectRead(4)){
			return 0;
		}
		
		uint32_t v = *(uint32_t*)(m_MsgBuf + m_ReadPos);
		m_ReadPos += 4;
		return v;
	}
	uint32_t peekU32(){
		if(!expectRead(4)){
			return 0;
		}
		
		uint32_t v = *(uint32_t*)(m_MsgBuf + m_ReadPos);
		return v;
	}
#else
	uint16_t getU16(){
		if(!expectRead(2)){
			return 0;
		}
		
		uint16_t v = *(uint16_t*)(m_MsgBuf + m_ReadPos);
		m_ReadPos += 2;
		return swap_uint16(v);
	}
	uint32_t getU32(){
		if(!expectRead(4)){
			return 0;
		}
		
		uint32_t v = *(uint32_t*)(m_MsgBuf + m_ReadPos);
		m_ReadPos += 4;
		return swap_uint32(v);
	}
	uint32_t peekU32(){
		if(!expectRead(4)){
			return 0;
		}
		
		uint32_t v = *(uint32_t*)(m_MsgBuf + m_ReadPos);
		return swap_uint32(v);
	}
#endif

	std::string getString();
	std::string getRaw();
	Position getPosition();

	// skips count unknown/unused bytes in an incoming message
	void skipBytes(int count){m_ReadPos += count;}

	// simply write functions for outgoing message
	void addByte(uint8_t value){
		if(canAdd(1)){
			m_MsgBuf[m_ReadPos++] = value;
			m_MsgSize++;
		}
	}

#ifndef __SWAP_ENDIAN__
	void addU16(uint16_t value){
		if(canAdd(2)){
			*(uint16_t*)(m_MsgBuf + m_ReadPos) = value;
			m_ReadPos += 2; m_MsgSize += 2;
		}
	}
	void addU32(uint32_t value){
		if(canAdd(4)){
			*(uint32_t*)(m_MsgBuf + m_ReadPos) = value;
			m_ReadPos += 4; m_MsgSize += 4;
		}
	}
#else
	void addU16(uint16_t value){
		if(canAdd(2)){
			*(uint16_t*)(m_MsgBuf + m_ReadPos) = swap_uint16(value);
			m_ReadPos += 2; m_MsgSize += 2;
		}
	}
	void addU32(uint32_t value){
		if(canAdd(4)){
			*(uint32_t*)(m_MsgBuf + m_ReadPos) = swap_uint32(value);
			m_ReadPos += 4; m_MsgSize += 4;
		}
	}
#endif

	void addBytes(const char* bytes, uint32_t size);
	void addPaddingBytes(uint32_t n);

	void addString(const std::string& value){addString(value.c_str());}
	void addString(const char* value);


	// write functions for complex types
	void addPosition(const Position &pos);
	void addItem(uint16_t id, uint16_t count);
	void addItem(const Item *item);
	void addItemId(const Item *item);
	void addItemId(uint16_t itemId);
	void addCreature(const Creature *creature, bool known, unsigned int remove);

	int32_t getMessageLength() const { return m_MsgSize; }
	void setMessageLength(int32_t newSize) { m_MsgSize = newSize; }
	int32_t getReadPos() const { return m_ReadPos; }
	void setReadPos(int32_t pos) {m_ReadPos = pos; }

	int32_t decodeHeader();
	
	bool isOverrun(){ return m_overrun; };
	bool isPriorized() const { return m_priorize; };

	uint8_t* getBuffer() { return m_MsgBuf; }
	const uint8_t* getBuffer() const { return m_MsgBuf; }
	char* getBodyBuffer() { m_ReadPos = 2; return (char*)&m_MsgBuf[header_length]; }

#ifdef __TRACK_NETWORK__
	virtual void track(std::string file, long line, std::string func) {};
	virtual void clearTrack() {};
#endif


protected:
	inline bool canAdd(uint32_t size){
		return (size + m_ReadPos < max_body_length);
	};
	
	inline bool expectRead(int32_t size){
		if(size >= (NETWORKMESSAGE_MAXSIZE - m_ReadPos)){
			m_overrun = true;
			return false;
		}
		
		return true;
	};

	int32_t m_MsgSize;
	int32_t m_ReadPos;
	
	bool m_overrun;
	bool m_priorize;

	uint8_t m_MsgBuf[NETWORKMESSAGE_MAXSIZE];
};

typedef boost::shared_ptr<NetworkMessage> NetworkMessage_ptr;

#endif // #ifndef __NETWORK_MESSAGE_H__
