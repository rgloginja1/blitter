pragma solidity >=0.4.22 <0.6.0;

contract Blitter {
  
    address public contractOwner;
    
    string public contractName;
    string public contractVersion;
    string public contractAuthor;
    
    string public message;
    address public messageOwner;
    
    string public messageOwnerNickname;
    uint8 public messageCount;
    
    uint public postPrice;
    
    event CreateLog(
        uint _value,
        uint _amount,
        address indexed _from
    );
    
    struct MessageHistory
    {
        string messageText;   
        address senderAddress;
        string senderNickname;
        uint8 messageNumber;
        bytes32 status;
    }
    
    MessageHistory[] public messages;
    
    mapping(address => MessageHistory[]) public messagesx;


    function Blitter() public {
       
        contractOwner = msg.sender;
        
        contractName = "Blitter";
        contractVersion = "0.0.1";
        contractAuthor = "VERITAS Software Pty Ltd";
        
        messageCount = 0;
        
        postPrice = 100000000000000;
        
    }
    function createPost(string newMessageA, string userNicknameA) public payable {
       
        if(msg.value > postPrice ){
            
            setMessage(newMessageA, userNicknameA);
            
            postPrice++;
            
            contractOwner.transfer(msg.value);
            
            
        } else {
            
            revert();
            
        }
        
    }
    
    function deleteMessage(uint8 numberT, string updatedMessage) public {
       
       var postGet1 = messages[numberT];
        
        if(postGet1.senderAddress == msg.sender){
            messages[numberT] = MessageHistory({
                messageText: 'This post has been removed',
                senderAddress: postGet1.senderAddress,
                senderNickname: postGet1.senderNickname,
                messageNumber: postGet1.messageNumber,
                status: 0
            });
        }
    
    }
    
    function getMessage(uint8 numberTT) public returns (string bid) {
        
        var bidd = messages[numberTT];
        
        if( bidd.senderAddress == msg.sender ){
            
            bid = 'This is your post!';
       
        } else {
            
            bid = "This was not posted by you";
        }
        
    }
    
    
    function getMyPostCount(address searchAddress) public returns (uint8 myCount) {
        
        var counterMain = messageCount;
        
        myCount = 0;
        
        for (uint i = 0; i < counterMain; i++) {
            
            var biddd = messages[i];
            
            if( biddd.senderAddress == msg.sender ){
            
                myCount++;
       
            }
            
        }
        
    }
    
    function setMessage(string newMessage, string userNickname) private {
        
        messageOwner = msg.sender;
        messageOwnerNickname = userNickname;
        message = newMessage;
        
        messages.push(MessageHistory({
            messageText: message,
            senderAddress: messageOwner,
            senderNickname: messageOwnerNickname,
            messageNumber: messageCount,
            status: 1
        }));
        
        CreateLog(messageCount, msg.value, msg.sender);
        
        messageCount++;
        
    }
}