/// @file Sound.hpp
/// @brief Header file for Sound.hpp
/// @author Eric Hamdan erichamdan@gmail.com

#ifndef SOUND
#define SOUND

#include <string>
#include <map>
#include "Buffer.hpp"
#include "SCServer.hpp"
#include "Node.hpp"

#define NEW_PAUSED 0
#define NEW 1

namespace sc {

  /// @brief This class represents a user manipulable Soundfile Player, essentially mirroring
  /// the OAS class of the same name by Shreenidhi Chowkwale
  /// @refs https://github.com/CalVR/Open-Audio-Server/blob/master/client/src/Sound.h
  class Sound 
  {
    public:
	
        /// Create a new sound source
	Sound(SCServer * other, const std::string &filepath, int outarray [], int initAction = 0);
  
      	/// Deallocates server-side buffer associated with this instance
	~Sound();

        // {@
	/// @name Playback Functions
	
	/// Play the sound source from the last position.
        void play();

        /// Pauses the sound source at the current playback position
        void pause();

        /// Set the looping state
	/// false = no looping, true = looping 
        /// @param[in] bool loop
        int setLoop(bool loop);
        // @}
       
        // {@
	/// @name Sound Parameter Functions

       /* /// Set the current playback position in seconds 
        /// @param[in] float seconds
	void setPlaybackPosition(float seconds);*/
  
        /// Set the current gain from 0 - 1
        /// @param[in] float gain
        void setGain(float gain);

        /// Set the current playback rate
	/// 1 is regular, 2 is double speed, .5 half speed etc.
	/// @param[in] float rateScalar
        void setRate(float rateScalar);

       /* /// Initiate a linear fade in/out relative to the
        /// gain at the time this function is called
        /// @param[in] float final gain
        /// @param[in] float fade duration
        void fade(float finalGain, float fadeDuration);*/
        // @}

        void jumpToStartPos();

	void setStartPosition(float pos);
 
        bool isValid() const {return _isValid;}
 
        bool isPlaying() const {return _isPlaying;}

        bool isLooping() const {return _isLooping;}
  
        int getId() const {return synth->getId();}

        int getChanNum() const {return buffer->getChanNum();}
    
        int getFrameNum() const {return buffer->getFrameNum();}

        float getGain() const {return _gain;}

	float getStartPos() const {return _startPos;}
    private:

        void init(SCServer * other, const std::string &filepath, int outarray [], int initAction);
	
	SCServer * cs;
	Buffer * buffer;
        Synth *  synth;

        std::map<std::string, float> args;
	
	float _pitchScalar;
	float _gain;
	float _startPos;
	float _rateScalar;
        int _initAction;
	bool _isLooping;
        bool _isPlaying;
        bool _isValid;
  };
} //namespace sc
#endif
