pragma solidity >=0.4.22 <0.6.0;

contract Blitter {
  
    address public contractOwner;
    
    string public contractName;
    string public contractVersion;
    string public contractAuthor;
    
    string message;
    address  messageOwner;
    
    string  messageOwnerNickname;
    uint8  messageCount;
    
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
        uint messageTimestamp;
    }
    
    MessageHistory[] public messages;
    
    mapping(address => MessageHistory[]) public messagesx;


    function Blitter() public {
       
        contractOwner = msg.sender;
        
        contractName = "Blitter";
        contractVersion = "0.0.2";
        contractAuthor = "VERITAS Software Pty Ltd";
        
        messageCount = 0;
        
        postPrice = 100000000000000;
        
    }
    function createPost(string newMessageA, string userNicknameA) public payable {
       
        if(msg.value >= postPrice ){
            
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
                status: 0,
                messageTimestamp: postGet1.messageTimestamp
            });
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
            status: 1,
            messageTimestamp: now
        }));
        
        CreateLog(messageCount, msg.value, msg.sender);
        
        messageCount++;
        
    }
}
